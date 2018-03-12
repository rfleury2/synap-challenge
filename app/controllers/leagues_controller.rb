class LeaguesController < ApplicationController
  before_action :find_event

  def index
    @leagues = @event.leagues
  end

  def show
    @league = @event.leagues.find(params[:id])
  end

  private 

  def find_event
    @event = Event.find(params[:event_id])
  end
end