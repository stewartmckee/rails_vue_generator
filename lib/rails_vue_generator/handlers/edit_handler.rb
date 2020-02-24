# frozen_string_literal: true

module RailsVueGenerator
  module Handlers
    class EditHandler < BaseHandler
      def template
        edit_form_lines = []
        edit_form_lines << '<template>'
        edit_form_lines << '<div>'
        edit_form_lines << "<div v-if='loading' class=\"spinner\">Loading #{model_name.titleize}</div>"
        edit_form_lines << "<div v-else>"
        ignored_columns = [:id]

        @model.columns.reject { |column| IGNORED_COLUMNS.include?(column.name.to_sym) }.each do |column|
          name = column.name
          type = column.type
          edit_form_lines << "<div class='form-group'>"
          case column.type
          when :boolean
            edit_form_lines << "<input type='checkbox' id='checkbox' v-model='#{model_name}.#{name}'>"
            edit_form_lines << "<label for='checkbox'>#{name.titleize}</label>"
          when :string
            input_type = if name.downcase == 'email'
                           'email'
                         else
                           'text'
              end
            edit_form_lines << "<label for='#{name}'>#{name.titleize}</label>"
            edit_form_lines << "<input type='#{input_type}' id='#{name}' v-model='#{model_name}.#{name}'>"
          when :integer
            edit_form_lines << "<label for='#{name}'>#{name.titleize}</label>"
            edit_form_lines << "<input type='number' id='#{name}' v-model='#{model_name}.#{name}'>"
          when :datetime
            edit_form_lines << "<label for='#{name}'>#{name.titleize}</label>"
            edit_form_lines << "<input type='datetime' id='#{name}' v-model='#{model_name}.#{name}'>"
          when :json
          when :text
            edit_form_lines << "<label for='#{name}'>#{name.titleize}</label>"
            edit_form_lines << "<textarea id='#{name}' v-model='#{model_name}.#{name}'/>"
          when :date
            edit_form_lines << "<label for='#{name}'>#{name.titleize}</label>"
            edit_form_lines << "<input type='date' id='#{name}' v-model='#{model_name}.#{name}'>"
          end
          edit_form_lines << '</div>'
        end
        edit_form_lines << "<div>"
        edit_form_lines << "<a href='#' class='btn btn-primary' @click=\"save\">Save Changes</a> "
        edit_form_lines << "<router-link :to=\"{name: '#{model_name.pluralize}'}\">Back</router-link>"
        edit_form_lines << '</div>'
        edit_form_lines << '</div>'
        edit_form_lines << '</div>'
        edit_form_lines << '</template>'
        edit_form_lines.join("\n")
      end

      def script
        lines = []

        lines << '<script>'
        lines << "  import {mapState} from 'vuex'"
        lines << '  export default {'
        lines << "    name: '#{model_name}-edit',"
        lines << '  computed:{'
        lines << '    ...mapState({'
        lines << "      #{model_name}: state => state.#{model_name}.current,"
        lines << "      loading: state => state.#{model_name}.loading.current"
        lines << '    }),'
        lines << '  },'
        lines << '  methods: {'
        lines << '    save(){'
        lines << "      const data = this.#{model_name}"
        lines << "      if (this.#{model_name}.id !== undefined) {"
        lines << "        const id = this.#{model_name}.id"
        lines << "        console.log(\"updating \", this.#{model_name})"
        lines << "        this.$store.dispatch('#{model_name}/update', {id, data}).then(function(response) {this.$router.push({name: '#{model_name}', params: {id: response.id}})}.bind(this))"
        lines << '      } else {'
        lines << "        console.log(\"updating \", this.#{model_name})"
        lines << "        this.$store.dispatch('#{model_name}/create', this.#{model_name}).then(function(response) {this.$router.push({name: '#{model_name}', params: {id: response.id}})}.bind(this))""
        lines << '      }'
        lines << '    }'
        lines << '  },'
        lines << '  created() {'
        lines << '    if (this.$route.params.id !== undefined) {'
        lines << "      this.$store.dispatch('#{model_name}/get', this.$route.params.id)"
        lines << "    } else {"
        lines << "      this.$store.dispatch('#{model_name}/clearCurrent', this.$route.params.id)"
        lines << "    }"
        lines << '  }'  
        lines << '};'
        lines << '</script>'
        lines.join("\n")
      end

      def style
        lines = []
        lines << "<style lang='scss' scoped>"
        lines << '</style>'
        lines.join("\n")
      end
    end
  end
end
