class MembersController < ApplicationController
  include Searchable

  def index
    if params[:search].present?
      search_members
    else
      @members = Member.all.where(archived: false).order(name: :asc).page(params[:page])
    end
  end

  def create
    begin
      ActiveRecord::Base.transaction do
        create_member(create_params)
      end
      flash[:success] = "Member created successfully."
    rescue => e
      flash[:error] = "Error creating member: #{e.message}"
    end

    redirect_to members_new_path
  end

  def new; end

  def show
    @member = Member.first
  end

  private

  def create_member(params)
    Member.create!(params)
  end

  def create_params
    params.require(:member).permit(:name, :email, :phone_number, :member_type)
  end
end
