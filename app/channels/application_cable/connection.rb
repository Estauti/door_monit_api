module ApplicationCable
  class Connection < ActionCable::Connection::Base 
    identified_by :current_user
 
    def connect                
      self.current_user = find_verified_user
    end
 
    private
      def find_verified_user   
        begin
          token = request.params[:jwt]
          decoded_token = JWT.decode token, nil, false
          user_id = Integer(decoded_token[0]["sub"])
          if (current_user = User.find(user_id))
            current_user
          else                 
            reject_unauthorized_connection
          end
        rescue StandardError => e
          puts e.message
          reject_unauthorized_connection  
        end
      end
  end
end
