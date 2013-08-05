#rails3-devise-bootstrap-example

Example Rails 3.2 / Ruby 1.9.3 site using devise and twitter-bootstrap. Facebox is used for modal 'lightbox' devise forms.

Demo site: <http://r3-dev-boot.gitrepoexamples.com>

###Recent Updates

March 2013:

- Added login via Twitter option using the omniauth-twitter gem.
- Added user image to top nav bar. If no image from Twitter, then look for one on Gravatar
- Email is no longer required.

July 2013:

- Restore email requirement, including with Twitter login
- Add Devise email confirmation (including confirmation email resend based on username)

##Installation

1. Download the zip file or clone this repository, then run:

  ```
  bundle install
  rake db:migrate
  ```

2. Register your application with Twitter. 

3. Add `config/database.yml` and `config/private.yml`.

  ```
  cp config/database-yml.todo config/database.yml
  cp config/private.yml.todo config/private.yml
  ```
  
  Update the two new files with your project specific settings.

  `config/private.yml` contains the settings not appropriate for saving in a public repository.

4. Update what's necessary for your hosting. Such as creating the `./tmp` and `./log` directories, editing the ngnix conf, etc.

###Capistrano

Please read the comments in `config/deploy.rb` for how these two locally maintained files are treated with a Capistrano deployment.

##Caveats:

Please note:

- There is a potential memory leak with bootstrap when working in the Rails development environment. The memory usage creeps up when I am editing bootstrap assets and doing iterative testing by just refreshing the browser and not restarting the app each time.
- Since I didn't use all of the devise features, you'll want to compare the original devise controllers and the overriding inherited controllers for what's missing.
- Assumes user has Javascript and cookies enabled.
- Only tested in latest version of Chrome and Firefox.


##Author

Joan Hughes

http://www.linkedin.com/in/jehughes

##License
The MIT License (MIT)

Copyright (c) 2013 Joan Hughes (ZoeOberon Solutions)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

![image](http://joanswork.com/images/gh_r3dboot_spot.png)

