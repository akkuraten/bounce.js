BaseView = require "scripts/views/base"
glMatrix = require "gl-matrix"

template = require "templates/inputs/translate"

class TranslateInputView extends BaseView
  template: template

  getInputValue: (name) =>
   parseFloat @$("input[name=#{name}]").val()

  addToBounce: (bounce, options) ->
    bounce.translate
      bounces: options.bounces
      shake: options.shake
      from:
        x: @getInputValue "from_x"
        y: @getInputValue "from_y"
      to:
        x: @getInputValue "to_x"
        y: @getInputValue "to_y"

module.exports = TranslateInputView
