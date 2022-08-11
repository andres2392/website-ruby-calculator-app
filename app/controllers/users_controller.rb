class UsersController < ApplicationController
  def my_search
    if current_user
      @tracked_pumps = current_user.pumps
    end
  end

  def finder
    if current_user
      @tracked_pumps = current_user.pumps
    end
  end
end
