
module RailsVueGenerator
  module Handlers
    class ApiHandler < BaseHandler

      def generate
        lines = []
        lines << "import axios from 'axios';"
        lines << ""
        lines << "export     const HTTP = axios.create({"
        lines << "  baseURL: process.env.VUE_APP_API_ENDPOINT || 'http://localhost:3000'"
        lines << "})"
        lines << ""
        lines << "export default {"

        lines << "  async getAll() {"
        lines << "    const response = await HTTP.get(`/#{model_name.pluralize}`)"
        lines << "    return response"
        lines << "  },"

        lines << "  async get(id) {"
        lines << "    const response = await HTTP.get(`/#{model_name.pluralize}/${id}`)"
        lines << "    return response"
        lines << "  },"
        
        lines << "  async create(data) {"
        lines << "    const response = await HTTP.post(`/#{model_name.pluralize}`, {#{model_name}: data})"
        lines << "    return response"
        lines << "  },"
        
        lines << "  async update(id, data) {"
        lines << "    const response = await HTTP.put(`/#{model_name.pluralize}/${id}`, {#{model_name}: data})"
        lines << "    return response"
        lines << "  },"
        
        lines << "  async delete(id) {"
        lines << "    const response = await HTTP.delete(`/#{model_name.pluralize}/${id}`)"
        lines << "    return response"
        lines << "  }"
        
        lines << "}"

        lines.join("\n")
      end
    end
  end
end