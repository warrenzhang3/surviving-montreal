class EventsController < ApplicationController
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
    @event.save
    redirect_to event_path(@event)
  end

  private

  def article_params
    params.require(:event).permit(:user, :title, :image_url, :location, :event_date, :number_of_people)
  end
end
