class StoresController < ApplicationController
    before_action :set_store, only: [:show, :edit, :update, :destroy]

    def index
      @stores = Store.all
    end
  
    def show
    end
  
    def new
      @store = Store.new
    end
  
    def create
      if store_params['category'] == "Drink"
        store_params_fixed = {"name"=>store_params['name'], "price"=>store_params['price'], "category"=>store_params['category'], "volume"=>store_params['volume'], "weight"=>nil}
        
      end
      if store_params['category'] == "Food"
        store_params_fixed = {"name"=>store_params['name'], "price"=>store_params['price'], "category"=>store_params['category'], "volume"=>nil, "weight"=>store_params['weight']}
       
      end
      
      if store_params['category'] == "Souvenir"
        store_params_fixed = {"name"=>store_params['name'], "price"=>store_params['price'], "category"=>store_params['category'], "volume"=>nil, "weight"=>nil}

        
      end
      
      @store = Store.new(store_params_fixed)
  
      if @store.save
        redirect_to stores_path, notice: "store was successfully created."
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @store.update(store_params)
        redirect_to stores_path, notice: "store was successfully updated."
      else
        render :edit
      end
    end
  
    def destroy
      @store.destroy
      redirect_to stores_path, notice: "store was successfully destroyed."
    end
  
    private
  
    def set_store
      @store = Store.find(params[:id])
    end
  
    def store_params
      params.require(:store).permit(:name,:price,:category,:volume,:weight)
    end
end
