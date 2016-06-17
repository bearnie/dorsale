module Dorsale
  module ExpenseGun
    class ApplicationController < ::Dorsale::ApplicationController
      before_action :set_form_variables

      def set_form_variables
        @categories ||= ::Dorsale::ExpenseGun::Category.all
      end
    end
  end
end
