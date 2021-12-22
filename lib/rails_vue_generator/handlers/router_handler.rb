# frozen_string_literal: true

module RailsVueGenerator
  module Handlers
    class RouterHandler < BaseHandler
      def generate
        routes = []
        routes << "  {\n    path: '/#{model_name.pluralize}',\n    name: '#{model_name.pluralize}',\n    component: () => import( /* webpackChunkName: \"#{model_name.pluralize}\" */ '@/views/#{model_name}/index.vue')\n  },\n"
        routes << "  {\n    path: '/#{model_name}/new',\n    name: 'new-#{model_name}',\n    component: () => import( /* webpackChunkName: \"#{model_name.pluralize}\" */ '@/views/#{model_name}/edit.vue')\n  },\n"
        routes << "  {\n    path: '/#{model_name}/:id',\n    name: '#{model_name}',\n    component: () => import( /* webpackChunkName: \"#{model_name.pluralize}\" */ '@/views/#{model_name}/show.vue')\n  ,\n"
        routes << "  {\n    path: '/#{model_name}/:id/edit',\n    name: 'edit-#{model_name}',\n    component: () => import( /* webpackChunkName: \"#{model_name.pluralize}\" */ '@/views/#{model_name}/edit.vue')\n  },\n"
        routes
      end
    end
  end
end
