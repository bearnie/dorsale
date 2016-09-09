module Dorsale::CustomerVault::Person
  extend ActiveSupport::Concern

  def self.t(*args)
    ::Dorsale::CustomerVault::Corporation.t(*args)
  end

  def self.policy_class
    Dorsale::CustomerVault::PersonPolicy
  end

  included do
    def self.policy_class
      Dorsale::CustomerVault::PersonPolicy
    end

    acts_as_taggable

    has_many :comments, -> { order("id DESC") }, class_name: ::Dorsale::Comment, as: :commentable, dependent: :destroy
    has_one :address, class_name: ::Dorsale::Address, as: :addressable, inverse_of: :addressable, dependent: :destroy
    has_many :tasks, class_name: ::Dorsale::Flyboy::Task, as: :taskable, dependent: :destroy
    accepts_nested_attributes_for :address, allow_destroy: true

    after_destroy :destroy_links

    def person_type
      self.class.to_s.split("::").last.downcase.to_sym
    end

    def tags_on(*args)
      super(*args).order(:name)
    end

    def links
      a = ::Dorsale::CustomerVault::Link.where(alice_id: self.id, alice_type: self.class.to_s).map {|l| {title: l.title, person: l.bob, origin: l}}
      b = ::Dorsale::CustomerVault::Link.where(bob_id: self.id, bob_type: self.class.to_s).map {|l| {title: l.title, person: l.alice, origin: l}}
      return a + b
    end

    def destroy_links
      links.map{ |l| l[:origin].destroy! }
    end
  end

end
