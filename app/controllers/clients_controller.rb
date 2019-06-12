class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
      @clients = Client.all
  end
  def new
    @client = Client.new
  end
  def edit
  end
  def show
  end
  def create
    Rails.logger.info "Params: #{client_params}"
    @client = Client.new(client_params)
    
    respond_to do |format|
      if @client.save
        format.html {redirect_to @client, notice: 'Client was successfully created.' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end
  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to @client,notice: 'Client was succesfully updated' }
      else
        format.html { render :edit }
      end
    end
  end
  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url, notice: 'Client was succesfully destroy' }
      format.json { head :no_content }
    end
  end
  private
  def set_client
    @client = Client.find(params[:id])
  end
  def client_params
    params.require(:client).permit(:name, :email, :tel, :drivinglicense)
  end

end
