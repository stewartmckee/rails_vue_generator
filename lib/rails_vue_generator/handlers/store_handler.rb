# frozen_string_literal: true

module RailsVueGenerator
  module Handlers
    class StoreHandler < BaseHandler
      def generate
        lines = []
        lines << "import api from '@/api'"
        lines << ''
        lines << 'const state = {'
        lines << '  current: {},'
        lines << '  all: [],'
        lines << '  loading: {'
        lines << '    current: false,'
        lines << '    all: false'
        lines << '  }'
        lines << '}'
        lines << ''
        lines << 'const actions = {'
        lines << '  async getAll({'
        lines << '    commit'
        lines << '  }, code) {'
        lines << "    commit('startLoading', 'all')"
        lines << "    const result = await api.#{model_name}.getAll()"
        lines << '    const responseData = result.data'
        lines << "    commit('store#{model_name.pluralize.titleize}', responseData)"
        lines << "    commit('endLoading', 'all')"
        lines << '    return responseData'
        lines << '  },'
        lines << '  async get({'
        lines << '    commit'
        lines << '  }, id) {'
        lines << "    commit('startLoading', 'current')"
        lines << "    const result = await api.#{model_name}.get(id)"
        lines << '    const responseData = result.data'
        lines << "    commit('store#{model_name.titleize}', responseData)"
        lines << "    commit('endLoading', 'current')"
        lines << '    return responseData'
        lines << '  },'
        lines << '  async create({commit}, data) {'
        lines << "    const result = await api.#{model_name}.create(data)"
        lines << '    const responseData = result.data'
        lines << "    commit('store#{model_name.titleize}', responseData)"
        lines << '    return responseData'
        lines << '  },'
        lines << '  async update({commit}, {id, data}) {'
        lines << "    commit('startLoading', 'current')"
        lines << "    const result = await api.#{model_name}.update(id, data)"
        lines << '    const responseData = result.data'
        lines << "    commit('store#{model_name.titleize}', responseData)"
        lines << "    commit('endLoading', 'current')"
        lines << '    return responseData'
        lines << '  },'
        lines << '  async delete({commit}, id) {'
        lines << "    const result = await api.#{model_name}.delete(id)"
        lines << '    const responseData = result.data'
        lines << "    commit('clearCurrent')"
        lines << '    return responseData'
        lines << '  },'
        lines << '  clearCurrent({commit}) {'
        lines << "    commit('clearCurrent')"
        lines << '  }'
        lines << ''
        lines << '}'
        lines << 'const mutations = {'
        lines << "  store#{model_name.titleize}(state, #{model_name}) {"
        lines << "    state.current = #{model_name}"
        lines << '  },'
        lines << "  store#{model_name.pluralize.titleize}(state, data) {"
        lines << '    state.all = data'
        lines << '  },'
        lines << '  clearCurrent(state) {'
        lines << '    state.current = {}'
        lines << '  },'
        lines << '  startLoading(state, key) {'
        lines << '    state.loading[key] = true'
        lines << '  },'
        lines << '  endLoading(state, key) {'
        lines << '    state.loading[key] = false'
        lines << '  }'
        lines << '}'
        lines << ''
        lines << 'export default {'
        lines << '  namespaced: true,'
        lines << '  state,'
        lines << '  actions,'
        lines << '  mutations'
        lines << '}'
        lines << ''

        lines.join("\n")
      end
    end
  end
end
