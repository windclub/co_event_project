class EventsController < ApplicationController
  before_action :require_login

  def require_login
    redirect_to '/login' unless session[:user]
  end

  def index
    @user = User.find(session[:user])
    @events_in_state = Event.where({ state: @user.state })
    @events_out_state = Event.where.not({ state: @user.state })
  end

  def create
    event = User.find(session[:user]).events.new(event_params)
    if event.valid?
      event.save
    else
      flash[:errors]=event.errors.full_messages
    end
    redirect_to '/events'
  end

  def join
    event = Event.find(params[:id])
    event.attendees.create(user_id: session[:user])
    redirect_to '/events'
  end

  def leave
    event = Event.find(params[:id])
    event.attendees.find_by_user_id(session[:user]).delete
    redirect_to '/events'
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    event = Event.find(params[:id])
    event.update(event_params)
    if event.valid?
      event.save
    else
      flash[:errors]=event.errors.full_messages
    end
    redirect_to '/events'
  end

  private
    def event_params
      params.require(:event).permit(:name, :date, :city, :state)
    end
end
