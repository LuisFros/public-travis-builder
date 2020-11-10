class InvitationsController < ApplicationController
    # Temporary workaround for no user login. 
    #               vvv
    #skip_before_action :authorized
    before_action :manage_auth

    def create
        if !params[:receiver_username] || !params[:room_id]
            return render json: {
                "error": "Some parameter(s) were not received correctly"
            }
        end
        #current_user = User.find_by(id: params[:user_id])
        receiver_user = User.find_by(username: params[:receiver_username])
        room = Room.find_by(id: params[:room_id])
        puts "-----------------"
        puts current_user.id
        puts room.user_id
        if current_user.id != room.user_id
            return render json: {
                "error": "The room you're trying to invite the user to is NOT yours."
            }
        end
        if !room.private_room
            return render json: {
                "error": "The room you're trying to invite the user to is NOT private."
            }
        end

        if !receiver_user
            return render json: {
                "error" => "receiver user not found"
            }
        end
        @invitation = Invitation.create({
            state: "Pending",
            sender_id: current_user.id,
            receiver_id: receiver_user.id,
            room_id: params[:room_id]
        })  
        return render json: {
            "invitation": @invitation
        }
    end

    def show
        #if !params[:user_id] || !params[:state]
        #    return render json: {
        #        "error": "Some parameter(s) were not received correctly"
        #    }
        #end
        #current_user = User.find_by(id: params[:user_id])
        invitations = Invitation.joins(:room).joins(:receiver).where(receiver_id: current_user.id, state: params[:state])
        return render json: {
            "invitations": invitations
        }
    end

    def update
        if !params[:state] || !params[:invitation_id]
            return render json: {
                "error" => "Some parameter(s) were not received correctly"
            }
        end
        
        #current_user = User.find_by(id: params[:user_id])
        invitation = Invitation.find_by(id: params[:invitation_id])
        if valid_token? == current_user.username
            if current_user && invitation
                room = Room.find_by(id: invitation.room_id)
                invitation.update(state: params[:state])

                if params[:state] == "Accepted"
                    room.users << current_user
                end
            else
                return render json:{
                    "error" => "could not update record: current user of invitation not found."
                }
            end
            return render json: {
                "invitation": invitation
            }
        else
            return render json: {
                "error": "you don't have permissions."
             }
        end
    end

end
