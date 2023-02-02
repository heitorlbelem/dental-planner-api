# frozen_string_literal: true

def claim_name(controller, action)
  "#{action}_#{controller}"
end

def create_claims(claims)
  claims.each do |controller, actions|
    actions.map do |action|
      Claim.create!(name: "#{action}_#{controller}")
    end
  end
end

def create_roles_and_link_claims(roles)
  roles.each do |role, claims_hash|
    created_role = Role.create!(name: role)

    claims_hash.each do |controller, actions|
      actions.each do |action|
        claim = Claim.find_by(name: claim_name(controller, action))
        Ability.create!(role: created_role, claim: claim)
      end
    end
  end
end

def add_privilege_to_user(claim_name, user)
  claim = Claim.find_by!(name: claim_name)
  Privilege.create!(user: user, claim: claim)
end

CRUD_OPERATIONS = %i[create update show destroy].freeze

claims = {
  users: CRUD_OPERATIONS,
  patients: CRUD_OPERATIONS,
  patients_addresses: CRUD_OPERATIONS && %i[show create],
  specific: [:teste]
}

roles = {
  admin: {
    users: claims[:users],
    patients: claims[:patients],
    patients_addresses: claims[:patients_addresses]
  },
  member: {
    users: claims[:users] && [:show],
    patients: claims[:patients],
    patients_addresses: claims[:patients_addresses]
  }
}

create_claims(claims)
create_roles_and_link_claims(roles)

User.create(
  username: 'admin',
  email: 'admin@sample.com',
  password: 'foobar123',
  first_name: 'Admin',
  last_name: 'Global',
  role: Role.find_by(name: 'admin')
)

User.create(
  username: 'member',
  email: 'member@sample.com',
  password: 'foobar123',
  first_name: 'Member',
  last_name: 'App',
  role: Role.find_by(name: 'member')
)

add_privilege_to_user('teste_specific', User.second)
