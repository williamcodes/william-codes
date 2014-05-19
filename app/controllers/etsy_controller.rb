class EtsyController < ApplicationController
  include EtsyHelper::InstanceMethods

  def for_etsy
  end

  def find_bacon
    actor = Actor.find_by(name: bacon_params[:name])
    actor ||= Actor.find_by(name: "Kevin Bacon")
    @bacon_finder = BaconFinder.new(actor)
    @bacon_finder.find_bacon
    @path = @bacon_finder.short_path
  end

  def neo_find_bacon
    @graph_maker = GraphMaker.new
    actor = Actor.find_by(name: proper_case(bacon_params[:name]))

    if actor
      @path = @graph_maker.bacon_path(actor)
    else
      @path = nil

    end
  end

  def actors
    if params[:query].present?
      @actors = Actor.search(params[:query], page: params[:page])
    else
      @actors = cast_of_frost_nixon
    end
  end

  def autocomplete
    render json: Actor.search(params[:query], autocomplete: true, limit: 10).map(&:name)
  end

  private
    def bacon_params
      params.permit(:name)
    end
end
