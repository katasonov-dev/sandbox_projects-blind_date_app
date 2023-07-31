class RestaurantsController < ApplicationController
  def select
    @restaurant = Restaurant.find(params[:restaurant_id])
    @group = Group.find(params[:id])

    if @group.leader_id == current_user.id
      @group.update(restaurant: @restaurant)
      flash[:notice] = 'Restaurant selected successfully.'
    else
      flash[:alert] = 'You are not the leader of this group.'
    end

    redirect_to @group
  end
end
