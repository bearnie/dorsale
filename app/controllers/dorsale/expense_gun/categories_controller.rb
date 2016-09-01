module Dorsale
  module ExpenseGun
    class CategoriesController < ::Dorsale::ExpenseGun::ApplicationController
      def index
        authorize! :index, Category
        @categories ||= ::Dorsale::ExpenseGun::Category.all
      end

      def new
        @category = ::Dorsale::ExpenseGun::Category.new
        authorize! :create, Category
      end

      def create
        @category = ::Dorsale::ExpenseGun::Category.new(category_params)
        authorize! :create, Category
        if @category.save
          flash[:notice] = "Category successfully added"
          redirect_to expense_gun_categories_url
        else
          render action: "new"
        end
      end

      def edit
        @category = ::Dorsale::ExpenseGun::Category.find(params[:id])
        authorize! :update, Category
      end

      def update
        @category = ::Dorsale::ExpenseGun::Category.find(params[:id])
        authorize! :update, Category
        if @category.update_attributes(category_params)
          flash[:notice] = "Category successfully updated"
          redirect_to expense_gun_categories_path
        else
          render action: "edit"
        end
      end

      private

      def permitted_params
        [
          :name,
          :code,
          :vat_deductible,
        ]
      end

      def category_params
        params.require(:expense_gun_category).permit(permitted_params)
      end
    end
  end
end