class RecipesController < ApplicationController
    before_action :authenticate_user!, only: :create
    
    def index
      recipes = Recipe.includes(:user).all
      render json: recipes, include: { user: { only: [:username, :image_url, :bio] } }
    end
  
    def create
      recipe = current_user.recipes.build(recipe_params)
  
      if recipe.save
        render json: recipe, include: { user: { only: [:username, :image_url, :bio] } }, status: :created
      else
        render json: { errors: recipe.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    def recipe_params
      params.require(:recipe).permit(:title, :instructions, :minutes_to_complete)
    end
  end
  