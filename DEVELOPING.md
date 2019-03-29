Thanks for your interest! Here's some notes on why this is developed in the way it is.


**Why is diff used for config files?**

We like using the latest version of software. Using diffs to create the final config files means that it should work just fine if a developer adds a new line to the config file, removes a line, etc. If we tried to just bundle a working config file wholesale (as `ircd-irc2` does), then every update we'd need to recreate the config file from scratch.


**How do I update the diffs?**

Grab a new copy of the software (new git clone, etc). Than apply the patch the same way the Dockerfile does. Then update the file, and then create a new patch. For a standard git patch this would look like:

```sh
git clone blahblah ircd-src
cd ircd-src
git apply ~/path/to/test-servers/server/ircd-config.patch
vim doc/ircd.conf.example
git diff > ~/path/to/test-servers/server/ircd-config.patch
```


**Why do some allow TLS and some not?**

Some server software just doesn't provide the ability to use TLS. On some, I'm simply a little lazy. It's not super necessary regardless, and I mostly want to provide it to test things like TLS IRCv3 capabilities and the like.


**Would you allow contributions?**

Sure! Right now we have a licensing question to work out, but once that's sorted I'd love to see this get extended with better images and more images.


**Why do this?**

Plain and simple, to provide a decent base for IRC server testing software to use. No need to go configure a bunch of servers from scratch or something else, I can just use these images and get a reasonable, well-configured machine that should let me test whatever I need to.
