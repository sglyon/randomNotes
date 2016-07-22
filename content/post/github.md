---
title: "GitHub pro tips"
date: "2016-01-04"
author: "Spencer Lyon"
series: ["Hacking"]
tags: ["tips", "github"]
---

## Post-commit hooks

You can use github post commit hooks to send an HTTP payload to a server after
every commit. The payload will contain data about the commit that you can then
use to trigger arbitrary actions (e.g. run scripts) on the server.

I've used a simple go library [webhook](https://github.com/adnanh/webhook) to do
this. To get it up and running I did the following:

1. Install `webhook` with: `go get github.com/adnanh/webhook`
2. Configure a post-commit webhook on github by:
  - Going to the repository settings then "Webhooks and services"
  - Clicking "Add webook"
  - Enter `http://SERVER-IP:9000/hooks/HOOK-ID`, where `SERVER-IP` is the ip address of the server and `HOOK-ID` is the name of a hook I will use in the next step
  - Enter a "password" in the `secret` field. Will be used later
3. Create a `hooks.json` file with the contents of [this example](https://github.com/adnanh/webhook/wiki/Hook-Examples#incoming-github-webhook). In the example `HOOK-ID` is given by the `"id"` field in the only element of the JSON array.
4. Change the `execute-command` to the script I want to run and `command-working-directory` to where I want ro run the script (also change the `secret` to what I chose in step 2)
5. Run `$GOPATH/bin/webhook -hooks hooks.json -verbose` to start the server (assumes `$GOPATH` is set properly)

That's it! Now, every time we push a commit to master the script runs locally on
our machine.

Note that if we kill the process running webhook the hooks won't work anymore. I
start the server on a remote machine using `nohup` and `&`. The actual command I
used was

```bash
nohup $GOPATH/bin/webhook -hooks hooks.json -verbose > webhook.out 2> webhook.err < /dev/null &
```

See the example `hook.json` file [here](https://github.com/DaveBackus/Data_Bootcamp/blob/master/website/hook.json)


## Jupyter notebooks in gists

Here’s what I do to put a notebook in a gist:

1. Go here https://gist.github.com
2. Create a new public gist
3. Name the file `my_notebook.ipynb` and write ​_something_​ in it.
4. Once the gist has been created and you are viewing it click the url and copy the big long string at the end. It could look like `82e0defcbddb09dd021df771bcf5a4b6`
5. Clone the gist as a repo to your computer using `git clone git@gist.github.com:BIGLONGSTRING.git notebook_gist` where `BIGLONGSTRING` is the thing from step 4 and `notebook_gist` is the name of the folder on your comptuer
6. Copy your actual notebook into `notebook_gist` folder, then add, commit, push like normal
7. After pushing go to [nbviewer](http://nbviewer.jupyter.org) and paste `BIGLONGSTRING` into the seach box on their site. This should load up the notebook from your gist and you're done!

To update the notebook, simply put a new version of it into that `notebook_gist` repo, commit, and push. The changes should go live on nbviewer.

If you aren't seeing an updated version of the notebook after pushing to the gist repo, you might need to visit the url in private mode or reset the browser cache.
