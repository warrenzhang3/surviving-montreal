# app/controllers/events_controller.rb
class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:going, :my_events]

  def index
    @events = Event.all
    if params[:query].present?
      query = "%#{params[:query]}%"
      @events = @events.joins(:user).where(
        "events.title ILIKE :query OR users.first_name ILIKE :query OR users.last_name ILIKE :query",
        query: query
      )
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user

    if @event.save
      message = "Event created successfully!"
      if current_user.events.count == 1 && !current_user.badges.exists?(name: 'First Event Create')
        current_user.award_badge('First Event Create')
        current_user.check_winter_survival_badge
        message += " You have earned a new badge!"
      elsif current_user.badges.where(name: ['First Article', 'Attend Your First Event', 'First Event Create']).count >= 3
        message = "Congratulations! You've also received the 'Survived Your First Winter' badge."
      end
      redirect_to events_path, notice: message
    else
      flash.now[:alert] = @event.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  def going
    message = "Bookings successfully!"
    @event = Event.find(params[:id])
    unless current_user.events.include?(@event)
      current_user.events << @event
      if current_user.events.count == 1 && !current_user.badges.exists?(name: 'Attend Your First Event')
        current_user.award_badge('Attend Your First Event')
        current_user.check_winter_survival_badge
        message += " You have earned a new badge!"
      end
      if current_user.badges.where(name: ['First Article', 'Attend Your First Event', 'First Event Create']).count >= 3
        message = "Congratulations! You've also received the 'Survived Your First Winter' badge."
      end
    end
    redirect_to my_events_path, notice: message
  end

  def my_events
    @events = current_user.events
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :location, :event_date, :number_of_people, images: [])
  end
end
