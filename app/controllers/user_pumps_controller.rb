class UserPumpsController < ApplicationController
    def create
        pump = Pump.check_db(params[:pump_name])
        @user_pump = UserPump.create(user: current_user, pump: pump)
        flash[:notice] = "Pump #{pump.name} added to list"
        redirect_to my_search_path
    end


    def destroy
        pump = Pump.find(params[:id])
        user_pump = UserPump.where(user_id: current_user.id, pump_id: pump.id ).first
        user_pump.destroy
        flash[:notice] = "#{pump.name} was successfully removed from my searchs"
        redirect_to my_search_path
    end
end
