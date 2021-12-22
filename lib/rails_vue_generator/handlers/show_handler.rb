module RailsVueGenerator
  module Handlers
    class ShowHandler < BaseHandler
      def template
        show_page_lines = []
        show_page_lines << "<template>"
        show_page_lines << "  <div>"
        ignored_columns = [:id]
        show_page_lines << "    <div v-if='loading' class=\"spinner\">Loading #{model_name.titleize}</div>"
        show_page_lines << "    <div v-else>"
        show_page_lines << "      <table>"
        @model.columns.reject { |column| IGNORED_COLUMNS.include?(column.name.to_sym) }.each do |column|
          show_page_lines << "        <tr>"
          show_page_lines << "          <th>#{column.name.titleize}</th><td>{{#{model_name}.#{column.name}}}</td>"
          show_page_lines << "        </tr>"
        end
        show_page_lines << "      </table>"
        show_page_lines << "      <div>"
        show_page_lines << "        <router-link :to=\"{name: 'edit-#{model_name}', params: {id: #{model_name}.id}}\">Edit</router-link>"
        show_page_lines << "        <a href='#' @click='deleteRecord'>Delete</a>"
        show_page_lines << "      </div>"
        show_page_lines << "    </div>"
        show_page_lines << "  </div>"
        show_page_lines << "</template>"
        show_page_lines.join("\n")
      end

      def script
        lines = []

        lines << "<script>"
        lines << "import {mapState} from 'vuex'"
        lines << "export default {"
        lines << "  name: '#{model_name}-show',"
        lines << "  computed: {"
        lines << "    ...mapState({"
        lines << "      #{model_name}: state => state.#{model_name}.current,"
        lines << "      loading: state => state.#{model_name}.loading.current"
        lines << "    })"
        lines << "  },"
        lines << "  created() {"
        lines << "    this.$store.dispatch('#{model_name}/get', this.$route.params.id)"
        lines << "  },"
        lines << "  methods: {"
        lines << "    deleteRecord() {"
        lines << "      this.$store.dispatch('#{model_name}/delete', this.#{model_name}.id).then(function(response) {this.$router.push({name: '#{model_name.pluralize}'})}.bind(this))"
        lines << "    }"
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
