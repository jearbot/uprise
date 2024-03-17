module MembersSearchable
  extend ActiveSupport::Concern

  def search_members(archived: false)
    members_table = Member.arel_table
    search_term = self.params[:search].downcase if self.params[:search].present?

    @members =
    if Member.member_types.keys.include?(search_term)
      Member.where(members_table[:member_type].eq(search_term)).where(archived: archived).page(self.params[:page])
    else
      query = Member.where(
        members_table[:email].lower.matches("%#{search_term}%").
        or(members_table[:normalized_phone_number].matches("%#{search_term}%")).
        or(members_table[:name].lower.matches("%#{search_term}%"))
      )
      query = query.where(archived: archived) if archived.present?
      query.page(self.params[:page])
    end
  end
end
