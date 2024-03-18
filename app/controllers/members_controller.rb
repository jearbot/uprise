class MembersController < ApplicationController
  include MembersSearchable

  def new; end

  def show
    @member = Member.find(params[:id])
  end

  def index
    if params[:search].present?
      search_members
    elsif params[:scope] == 'student'
      @members = Member.active.student.order(name: :asc).page(params[:page])
    elsif params[:scope] == 'volunteer'
      @members = Member.active.volunteer.order(name: :asc).page(params[:page])
    else
      @members = Member.active.all.order(name: :asc).page(params[:page])
    end
  end

  def create
    begin
      ActiveRecord::Base.transaction do
        Member.create!(params)
      end
      flash[:success] = "Member created successfully."
    rescue ActiveRecord::RecordInvalid => e
      flash[:alert] = "Error creating member: #{e.message}"
    end

    redirect_to members_path
  end

  def destroy
    begin
      ActiveRecord::Base.transaction do
        member = Member.find(destroy_params[:id])
        member.destroy!
      end
      flash[:success] = "Member deleted successfully."
    rescue ActiveRecord::RecordNotFound => e
      flash[:alert] = "Error deleting member: #{e.message}"
    end

    redirect_to members_path
  end

  def update
    begin
      ActiveRecord::Base.transaction do
        member = Member.find(params[:id])
        member.update!(parsed_params(member, update_params))
      end
      flash[:success] = "Member updated successfully."
    rescue ActiveRecord::RecordNotFound => e
      flash[:alert] = "Error updating member: #{e.message}"
    rescue ActiveModel::UnknownAttributeError => e
      flash[:alert] = "Error updating member: #{e.message}"
    end

    redirect_to members_path
  end

  private

  def create_params
    params.require(:member).permit(:name, :email, :phone_number, :member_type)
  end

  def update_params
    permitted_params = params.require(:member).permit(
      :name,
      :email,
      :phone_number,
      :member_type,
      :archived,
      :unsubscribed,
      data: {},
    )

    dynamic_params = {
      keys: params[:data_keys],
      values: params[:data_values],
    }

    permitted_params.merge(dynamic_params)
  end

  def destroy_params
    params.permit(:id)
  end

  def parsed_params(member, parameters)
    return unless parameters[:keys].present? && parameters[:values].present?

    parameters[:keys].each_with_index do |key, index|
      safe_key = key&.gsub(/[^a-zA-Z\s]/, '')&.rstrip&.gsub(/\s+/, '_')&.downcase
      value = parameters[:values][index]&.rstrip

      next if safe_key.blank?
      next if value.blank?

      parameters[:data].merge!({ "#{safe_key}" => "#{value}" })
    end

    parameters.delete(:keys)
    parameters.delete(:values)

    parameters
  end
end
