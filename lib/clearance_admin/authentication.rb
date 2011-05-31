module Clearance
  module Admin
    def self.included(controller) # :nodoc:
      controller.send(:include, InstanceMethods)
      controller.class_eval do
        helper_method :signed_in_as_admin?
      end
    end

    module InstanceMethods
      # Checks wheter an user has sign in and it's an admin
      #
      # @return [true, false]
      def signed_in_as_admin?
        signed_in? && current_user.admin?
      end

      # Denies access for non-users
      #
      def users_only
        deny_access("You must be signed in to access this page.") unless signed_in?
      end

      # Denies access for non-admins
      #
      def admin_only
        deny_access("You must be signed in as an admin to access this page.") unless signed_in_as_admin?
      end
    end
  end
end
