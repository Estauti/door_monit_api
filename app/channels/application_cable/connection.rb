module ApplicationCable
  class Connection < ActionCable::Connection::Base 
    identified_by :current_user
 
    def connect                
      self.current_user = find_verified_user
    end
 
    private
      def find_verified_user   
        begin
          token = request.headers[:authorization].split(' ').last
          decoded_token = JsonWebToken.decode(token)
          if (current_user = User.find(decoded_token["user_id"]))
            current_user
          else                 
            reject_unauthorized_connection
          end
        rescue
          reject_unauthorized_connection  
        end
      end
  end
end
