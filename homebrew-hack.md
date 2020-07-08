Sometimes, we need older packages/libraries that are not available on Homebrew. 

Understanbly it is hard enough to maintain so many packages, let alone having multiple versions of them available. Homebrew team also work very hard to make sure the versioned packages are still supported by their respective creators/maintainers. 

However, what if the version that we need isn't on Homebrew. Hope is not lost, here is a quick way to hack the desired version locally. Here I am using Hugo static site generator as an example. 

First get the url of the release package. When in doubt which file or how the link looks like, refer to the main formulae under https://github.com/Homebrew/homebrew-core/tree/master/Formula. In our case [this file here](https://github.com/Homebrew/homebrew-core/blob/6a8f5692ae05d70f347ce194d9cd892370712239/Formula/hugo.rb). 

With the release package url, we create a template of the version formulae using the following command. 
`brew create https://github.com/gohugoio/hugo/archive/v0.70.0.tar.gz --set-name hugo@0.70.0`

Note that `--set-version 0.70.0 ` if version is following semver format, and the filename hugo@0.70.0 should dictate in this case it is v.0.70.0. 

The earlier command created file `hugo@0.70.0.rb` will be created on `/usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/` folder. Open it in the editor and fill in description and homepage. The rest of the content should be as close to the main formulae as possible. 

Once that is done, run `brew audit --new-formula hugo@0.70.0` to verify it is correct. Fix error if there is any. 

Then run `brew audit --strict --online hugo@0.70.0` for strict audit online. If that's OK, that means no big issue for submission.

Now, it is ready to be installed locally, run `brew install --build-from-source hugo@0.70.0`.  This should pull the 0.70.0 version directly from GoHugo and install it locally. 

Last, add the path to `.zshrc` or `.bashrc` by `echo 'export PATH="/usr/local/opt/hugo@0.72.0/bin:$PATH"' >> ~/.zshrc`. 

If one has gotten this far, one might feel charitable and want to contribute the formulaes back to Homebrew so others could benefit from it too. If so one desires, follow the respective guides to [commit and push to a forked repo](https://docs.brew.sh/Formula-Cookbook), and [Open a Pull Request]. 

However, be aware that [ALL THESE CONDITIONS HAS TO BE FULLFILLED](https://docs.brew.sh/Versions) or the PR won't be approved. These rules are there for good reasons I belive, as Homebrew has great responsibility in providing as stress-free as an experience for its users.

