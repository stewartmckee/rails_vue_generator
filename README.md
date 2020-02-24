# RailsVueGenerator

The Rails Vue Generator is intended to build a starter Vue application, or build a sample application you can copy and paste from.  The contents of the application are based on your rails application.  Its loosely based on the idea for building templates for views in rails when you build a scaffold.

Install by adding to your Gemfile

    gem 'rails_vue_generator'

Usage:

Start a rails console and run

    RailsVueGenerator::Generator.generate

This will generate a `vue_example` folder that contains the vue application sample code.