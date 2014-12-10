class EventsController < ApplicationController
  def index
    @events = Event.page(params[:page]).per(5)

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @events.to_xml }
      format.json { render :json => @events.to_json }
      # index.atom.buider
      format.atom { @feed_title = "My event list" }
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:notic] = "event was successfully created"
      redirect_to events_url
      #redirect_to :action => :index
    else
      redirect_to :action => :new
    end
  end
  
  def show
    @event = Event.find(params[:id])
    respond_to do |format|
      format.html { @page_title = @event.name } # show.html.erb
      format.xml # show.xml.builder
      format.json { render :json => { id: @event.id, name: @event.name }.to_json }
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      flash[:notice] = "event was successfully updated"
      redirect_to event_url(@event)
      #redirect_to :action => :show, :id => @event
    else
      render :action => :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    flash[:alert] = "event was successfully deleted"
    redirect_to :action => :index
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :category_id)
  end
end
