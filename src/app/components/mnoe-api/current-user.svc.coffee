# Service to update the current user

# We're not using angular-devise as the update functionality hasn't been
# merged yet.
# As we're using Devise + Her, we have custom routes to update the current user
# It then makes more sense to have an extra service rather than have customised
# fork of the upstream library

# MnoeCurrentUser.update(name: 'John')
# => PUT /mnoe/jpi/v1/current_user/update

# MnoeCurrentUser.updatePassword1({current_password: 'Password1', password: 'Password2', password_confirmation: 'Password2'})
# => PUT /mnoe/jpi/v1/current_user/update_password

angular.module 'mnoEnterpriseAngular'
  .service 'MnoeCurrentUser', (MnoeApiSvc) ->
    _self = @

    # Store the current_user promise
    # Only one call will be executed even if there is multiple callers at the same time
    userPromise = null

    # Store the selected organization
    @selectedOrganization = null

    # Get the current user
    @get = ->
      return userPromise if userPromise?
      userPromise = MnoeApiSvc.one('current_user').get()

    # TODO: update current @user
    # _self.get().put()
    @update = (data) ->
      currentUserApi.doPUT({user: data}, 'update')

    # TODO: update current @user
    @updatePassword = (passwordData) ->
      currentUserApi.doPUT({user: passwordData}, 'update_password')

    return @
