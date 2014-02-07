=begin
/*******************************************************************************

Copyright (c) 2013 Mango Games Interactive Pte Ltd

 

Permission is hereby granted, free of charge, to any person obtaining a copy

of this software and associated documentation files (the "Software"), to deal

in the Software without restriction, including without limitation the rights

to use, copy, modify, merge, publish, distribute, sublicense, and/or sell

copies of the Software, and to permit persons to whom the Software is

furnished to do so, subject to the following conditions:

 

The above copyright notice and this permission notice shall be included in

all copies or substantial portions of the Software.

*******************************************************************************/  
=end
class CreateUser < ActiveRecord::Migration
  # creates user table in configured mysql db
  def up
    create_table :user do |t|
      t.string :name
      t.string :externalid
      t.string :gender
    end
    #insert record into that user table
     ActiveRecord::Base.connection.execute(" INSERT INTO user (name, externalid, gender) VALUES ('mongosample','123456789', 'female');")
  end
  
end
