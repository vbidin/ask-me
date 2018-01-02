class PermissionsController < ApplicationController
  before_action :set_permission, only: [:show, :edit, :update, :destroy]

  def index
    @permissions = Permission.all
  end
end
