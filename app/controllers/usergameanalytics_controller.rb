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

class UsergameanalyticsController < ActionController::Base
  
  def userstatistics
    #get external id, name and gender from request
        extid=params[:externalid] 
        name=params[:name]
        gender=params[:gender]
        
        if( extid == nil || name == nil || gender == nil )
                 render :json => { 
                      :status => :error, 
                      :reason => "Invalid input parameters."
                    }.to_json
            return
        end
        
        @uga = Usergameanalytics.find_by(extid:extid)
       
        #if the session does not exist, then create a new session for the user
        if(@uga==nil)
            # first check if this is a new user or an existing user.
             @usr = User.find_by_externalid(extid)
            if(@usr == nil)
              #create a new user account
              @usr = User.findOrCreateUserByExternalId(extid, name, gender)
            else
               #if the user already exists, then update the name and gender
              @usr.name = name
              @usr.gender = gender
              @usr.save
            end
            #create a new analytics record
          @uga = Usergameanalytics.createUserAnalyticsRecord(extid)
        end
        @uganalytics = Usergameanalytics.updateNumberOfLogins(extid)
        # present the output in a JSON object 
        if(@uganalytics!= nil)
              render :json => { 
                      :status => :ok, 
                      :useranalytics_id => @uganalytics._id,    
                      :login_time => @uganalytics.lastlogin,
                      :user_id => @uganalytics.uid,
                      :ext_id => @uganalytics.extid,
                      :number_of_wins => @uganalytics.nwin,
                      :number_of_loses => @uganalytics.nlost,
                      :number_of_logins => @uganalytics.nlogin,
                      :number_of_disconnects => @uganalytics.ndisconnect,
                      :number_of_friends => @uganalytics.nfriend,
                      :purchases => @uganalytics.purchase
                      }.to_json
        else
              render :json => { 
                      :status => :error, 
                      :extid => extid,
                      :reason => "Login operation failed."
                      }.to_json
        end

  end
end