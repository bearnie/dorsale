module Dorsale::BillingMachine
  class << self
    def vat_modes
      [:single, :multiple]
    end

    def vat_mode
      @vat_mode ||= :single
    end

    def vat_mode=(new_mode)
      raise "invalid mode #{new_mode}" unless vat_modes.include?(new_mode)
      @vat_mode = new_mode
    end

    def invoice_pdf_model
      "::Dorsale::BillingMachine::Invoice#{vat_mode.to_s.capitalize}VatPdf".constantize
    end

    def quotation_pdf_model
      "::Dorsale::BillingMachine::Quotation#{vat_mode.to_s.capitalize}VatPdf".constantize
    end

  end
end
