# app/controllers/events_controller.rb
class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:going, :my_events]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to event_path(@event)
    else
      render :new
    end
  end

  def going
    @event = Event.find(params[:id])
    current_user.events << @event
    redirect_to my_events_path
  end

  def my_events
    @events = current_user.events
  end

  private

  def event_params
    params.require(:event).permit(:user, :title, :image_url, :location, :event_date, :number_of_people, :description)
  end
end
