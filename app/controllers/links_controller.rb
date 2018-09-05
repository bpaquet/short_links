class LinksController < ApplicationController
  before_action :authenticate, except: :redir
  before_action :set_link, only: [:show, :edit, :update, :destroy]
  
  def is_owner? link
    link.owners.include?(current_user.email)
  end

  def redir
    link = Link.find_by_name(params[:name])
    if link
      redirect_to link.target
    else
      render status: 404, plain: "Not found\n"
    end
  end

  # GET /links
  # GET /links.json
  def index
    @links = Link.where('owners LIKE ?', current_user.email)
  end

  # GET /links/1
  # GET /links/1.json
  def show
  end

  # GET /links/new
  def new
    @link = Link.new
    @link.owners = current_user.email
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  # POST /links.json
  def create
    @link = Link.new(link_params)

    unless is_owner? @link
      render :file => "public/401.html", :status => :unauthorized
      return
    end

    respond_to do |format|
      if @link.save
        format.html { redirect_to @link, notice: 'Link was successfully created.' }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
    unless is_owner? @link
      render :file => "public/401.html", :status => :unauthorized
      return
    end
    
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to @link, notice: 'Link was successfully updated.' }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    unless is_owner? @link
      render :file => "public/401.html", :status => :unauthorized
      return
    end
    
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:name, :target, :owners)
    end
end
