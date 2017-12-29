class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.all.sort_by { |r| r.id }
    @rooms.each { |r| r.role = get_role r }
    @room = Room.new
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    @role = get_role @room
    raise "Room is closed" if @room.closed && @role.name != "Admin"
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms
  # POST /rooms.json
  def create

    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        # set the current user as room administrator
        @permission = Permission.new(user: current_user, room: @room, role: Role.admin)
        @permission.save
        
        format.html { redirect_to @room, notice: 'Room was successfully created.' }
        format.json { render :show, status: :created, location: @room }
        format.js
      else
        format.html { render :new }
        format.json { render json: @room.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to @room, notice: 'Room was successfully updated.' }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to rooms_url, notice: 'Room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    def get_role room
      perm = Permission.find do |p|
        p.user == current_user && p.room == room
      end

      role = perm.nil? ? Role.default : perm.role
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(:name, :open)
    end
end
