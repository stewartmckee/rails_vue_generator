module RailsVueGenerator
  module Handlers
    class IndexHandler < BaseHandler
      def template
        index_page_lines = []
        index_page_lines << "<template>"
        index_page_lines << "  <div>"
        index_page_lines << "    <h1>#{model_name.titleize}</h1>"
        index_page_lines << "    <div class=\"spinner\" v-if='loading'>Loading #{model_name.pluralize.titleize}</div>"
        index_page_lines << "    <div v-else>"
        index_page_lines << "      <table>"
        index_page_lines << "        <tr>"
        @model.columns.reject { |column| IGNORED_COLUMNS.include?(column.name.to_sym) }.each do |column|
          index_page_lines << "          <th>#{column.name.titleize}</th>"
        end
        index_page_lines << "          <th></th>"
        index_page_lines << "        </tr>"

        index_page_lines << "        <tr v-for='#{model_name.downcase} in #{model_name.downcase.pluralize}' :key='#{model_name.downcase}.id'>"
        @model.columns.reject { |column| IGNORED_COLUMNS.include?(column.name.to_sym) }.each do |column|
          index_page_lines << "        <td>{{#{model_name.downcase}.#{column.name}}}</td>"
        end
        index_page_lines << "          <td>"
        index_page_lines << "            <router-link :to=\"{name: '#{model_name}', params: {id: #{model_name.downcase}.id}}\">Show</router-link>&nbsp;|&nbsp;"
        index_page_lines << "            <router-link :to=\"{name: 'edit-#{model_name}', params: {id: #{model_name.downcase}.id}}\">Edit</router-link>"
        index_page_lines << "          </td>"
        index_page_lines << "        </tr>"
        index_page_lines << "      </table>"
        index_page_lines << "      <router-link :to=\"{name: 'new-#{model_name}'}\">Create a new #{model_name.titleize}</router-link>"
        index_page_lines << "    </div>"
        index_page_lines << "   </div>"
        index_page_lines << "</template>"
        index_page_lines.join("\n")
      end

      def script
        lines = []

        lines << "<script>"
        lines << "import {mapState} from 'vuex'"
        lines << "export default {"
        lines << "  name: '#{model_name}-edit',"
        lines << "  computed: {"
        lines << "    ...mapState({"
        lines << "      #{model_name.pluralize}: state => state.#{model_name}.all,"
        lines << "      loading: state => state.#{model_name}.loading.all"
        lines << "    })"
        lines << "  },"
        lines << "  created() {"
        lines << "    this.$store.dispatch('#{model_name}/getAll')"
        lines << "  }"
        lines << "}"
        lines << "</script>"
        lines.join("\n")
      end

      def style
        lines = []
        lines << "<style lang='scss' scoped>"
        lines << "</style>"
        lines.join("\n")
      end
    end
  end
end
