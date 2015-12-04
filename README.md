<img src="https://upload.wikimedia.org/wikipedia/commons/6/6f/ChessSet.jpg" alt="Drawing" width="400" height="400"/>

## Synopsis

  This project was inspired by the "Game Explorer App" featured on [Chess.com](https://www.chess.com "Chess.com's Homepage"). I wanted a way to utilize the Game Explorer to study my own games as well as GM's. So I set out to build similar functionality in this app. This is first and foremost a study tool. Patterns play a large role in chess, and the ability to find and understand them is important. Using this app You can look through your past games (or a play new one) and study them for mistakes.

## Installation

* `git clone` this repo.
* `cd` into the project directory
* Install various dependencies (postgres, ruby, rails, rake)
* `bundle install` to install gem dependencies
* `rake db:create` to create db
* `rake db:schema:load` to load database tables
* `rake db:seed` to seed the db
* `rails s` to start the server
* `rspec` to test both acceptance and unit tests

## Technologies Used

* Ruby
* Rails
* Postgresql
* ActiveRecord
* Rspec/Capybara/Shoulda-matchers/FactoryGirl/Simplecov/Byebug
* Bootstrap/Jquery
* [ChessBoard.js](https://github.com/oakmac/chessboardjs)
* [Chess.js](https://github.com/jhlywa/chess.js)
* Devise
* wikipedia-client
* And I am sure I am missing a few.

## Features to Add / TODO

* PGN Validation
* PGN Parser
* Stockfish AI
* Incorporate Redis and Sidekiq for background jobs to improve performance and find/display game statistics.
* Notes for individual moves / games
* Display games by players and date
* Better error messages / exceptions
* Improve test coverage and make tests more flexible.

## Special Thanks

*  _Josue V._ - For helping with bug fixing.
*  _Jeremiah H._ - For answering a never-ending sea of programming questions.
 
## License

Copyright (c) 2015 **_Mike Bunker_**

This software is licensed under the MIT license.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
