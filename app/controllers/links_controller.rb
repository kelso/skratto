class LinksController < ApplicationController
  def index
    @links = Link.all
  end

  def show
    @link = Link.find params[:id]
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new params[:link].permit(:original_url)
    #@link.code = SecureRandom.hex[0..6]

    if @link.save
      redirect_to @link
    else
      flash[:alert] = "Link sa nepodarilo uložiť"
      render :new
    end
  end

  def destroy
    @link = Link.find params[:id]
    @link.destroy
    flash[:notice] = "Link bol odstránený."
    redirect_to links_url
  end

  def redirect
    @link = Link.where(code: params[:code]).first
    if @link
      @link.visit_count += 1
      @link.save
      redirect_to @link.original_url
    else
      flash[:alert] = "Neznámy odkaz"
      redirect_to root_url
    end
  end
end
