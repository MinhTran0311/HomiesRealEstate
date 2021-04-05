﻿var chatService = abp.services.app.chat;
var friendshipService = abp.services.app.friendship;

var chat = {
    friends: [],
    tenantToTenantChatAllowed: abp.features.isEnabled('App.ChatFeature.TenantToTenant'),
    tenantToHostChatAllowed: abp.features.isEnabled('App.ChatFeature.TenantToHost'),
    serverClientTimeDifference: 0,
    selectedUser: null,
    isOpen: false,

    getFriendOrNull: function (userId, tenantId) {
        var friend = _.where(chat.friends, {
            friendUserId: parseInt(userId),
            friendTenantId: tenantId ? parseInt(tenantId) : null
        });
        if (friend.length) {
            return friend[0];
        }

        return null;
    },

    getFixedMessageTime: function (messageTime) {
        return moment(messageTime).add(-1 * chat.serverClientTimeDifference, 'seconds').format('YYYY-MM-DDTHH:mm:ssZ');
    },

    getFriendsAndSettings: function (callBack) {
        chatService.getUserChatFriendsWithSettings().done(function (result) {
            chat.friends = result.friends;
            chat.serverClientTimeDifference = app.calculateTimeDifference(abp.clock.now(), result.serverTime, 'seconds');

            chat.triggerUnreadMessageCountChangeEvent();
            chat.renderFriendLists(chat.friends);
            callBack();
        });
    },

    loadLastState: function () {
        app.localStorage.getItem('app.chat.isOpen', function (isOpen) {
            chat.isOpen = isOpen;
            chat.adjustNotifyPosition();

            app.localStorage.getItem('app.chat.pinned', function (pinned) {
                chat.pinned = pinned;
                var $sidebarPinner = $('a.page-quick-sidebar-pinner');
                $sidebarPinner.find('i:eq(0)').attr("class", "fa fa-map-pin " + (chat.pinned ? '' : 'fa-rotate-90'));
            });

            if (chat.isOpen) {
                $('body, #kt_quick_sidebar').addClass('offcanvas-on').promise().done(function () {
                    app.localStorage.getItem('app.chat.selectedUser', function (user) {
                        if (user) {
                            chat.showMessagesPanel();
                            chat.selectFriend(user.friendUserId, user.friendTenantId);
                        } else {
                            chat.showFriendsPanel();
                        }
                    });
                });
            }
        });
    },

    changeChatPanelIsOpenOnLocalStorage: function () {
        app.localStorage.setItem('app.chat.isOpen', chat.isOpen);
    },

    changeChatUserOnLocalStorage: function () {
        app.localStorage.setItem('app.chat.selectedUser', chat.selectedUser);
    },

    changeChatPanelPinnedOnLocalStorage: function () {
        app.localStorage.setItem('app.chat.pinned', chat.pinned);
    },

    changeChatPanelPinned: function (pinned) {
        chat.pinned = pinned;
        var $sidebarPinner = $(".page-quick-sidebar-pinner");
        $sidebarPinner.find('i:eq(0)').attr("class", "fa fa-map-pin " + (chat.pinned ? '' : 'fa-rotate-90'));

        chat.changeChatPanelPinnedOnLocalStorage();
    },

    //Friends
    selectFriend: function (friendUserId, friendTenantId) {
        var chatUser = chat.getFriendOrNull(friendUserId, friendTenantId);
        chat.selectedUser = chatUser;
        chat.changeChatUserOnLocalStorage();
        chat.user.setSelectedUserOnlineStatus(chatUser.isOnline);

        chat.showMessagesPanel();

        $('#selectedChatUserName').text(chat.user.getShownUserName(chat.selectedUser.friendTenancyName, chat.selectedUser.friendUserName));
        $('#ChatMessage').val('');

        if (chat.selectedUser.state !== app.consts.friendshipState.blocked) {
            $('#liBanChatUser, #ChatMessageWrapper').show();
            $('#liUnbanChatUser, #UnblockUserButton').hide();
            $('#ChatMessage').removeAttr("disabled");
            $('#ChatMessage').focus();
            $('#SendChatMessageButton').removeAttr("disabled");
        } else {
            $('#liBanChatUser, #ChatMessageWrapper').hide();
            $('#liUnbanChatUser, #UnblockUserButton').show();
            $('#ChatMessage').attr("disabled", "disabled");
            $('#SendChatMessageButton').attr("disabled", "disabled");
        }

        if (!chatUser.messagesLoaded) {
            chat.user.loadMessages(chatUser, function () {
                chatUser.messagesLoaded = true;
                chat.scrollToBottom();
            });
        } else {
            var renderedMessages = chat.renderMessages(chatUser.messages);
            $('#UserChatMessages').html(renderedMessages);
            chat.scrollToBottom();
            $(".timeago").timeago();

            chat.user.markAllUnreadMessagesOfUserAsRead(chat.selectedUser);
        }
    },

    initConversationScrollbar: function () {
        var chatAsideEl = KTUtil.getById('kt_quick_sidebar');

        var scrollEl = KTUtil.find(chatAsideEl, '.scroll');
        var cardBodyEl = KTUtil.find(chatAsideEl, '.card-body');
        var cardHeaderEl = KTUtil.find(chatAsideEl, '.card-header');
        var cardFooterEl = KTUtil.find(chatAsideEl, '.card-footer');

        if (!scrollEl) {
            return;
        }
        
        KTUtil.scrollInit(scrollEl, {
            mobileNativeScroll: true,  // enable native scroll for mobile
            desktopNativeScroll: false, // disable native scroll and use custom scroll for desktop 
            resetHeightOnDestroy: true,  // reset css height on scroll feature destroyed
            handleWindowResize: true, // recalculate hight on window resize
            rememberPosition: true, // remember scroll position in cookie
            height: function () {  // calculate height
                var height;

                if (KTUtil.isBreakpointDown('lg')) { // Mobile mode
                    return KTUtil.hasAttr(scrollEl, 'data-mobile-height') ? parseInt(KTUtil.attr(scrollEl, 'data-mobile-height')) : 400;
                } else if (KTUtil.isBreakpointUp('lg') && KTUtil.hasAttr(scrollEl, 'data-height')) { // Desktop Mode
                    return parseInt(KTUtil.attr(scrollEl, 'data-height'));
                } else {
                    height = KTLayoutContent.getHeight();

                    if (scrollEl) {
                        height = height - parseInt(KTUtil.css(scrollEl, 'margin-top')) - parseInt(KTUtil.css(scrollEl, 'margin-bottom'));
                    }

                    if (cardHeaderEl) {
                        height = height - parseInt(KTUtil.css(cardHeaderEl, 'height'));
                        height = height - parseInt(KTUtil.css(cardHeaderEl, 'margin-top')) - parseInt(KTUtil.css(cardHeaderEl, 'margin-bottom'));
                    }

                    if (cardBodyEl) {
                        height = height - parseInt(KTUtil.css(cardBodyEl, 'padding-top')) - parseInt(KTUtil.css(cardBodyEl, 'padding-bottom'));
                    }

                    if (cardFooterEl) {
                        height = height - parseInt(KTUtil.css(cardFooterEl, 'height'));
                        height = height - parseInt(KTUtil.css(cardFooterEl, 'margin-top')) - parseInt(KTUtil.css(cardFooterEl, 'margin-bottom'));
                    }
                }

                // Remove additional space
                height = height - 2;
                
                return height;
            }
        });

        $("#kt_chat_content .slimScrollDiv").slimScroll().bind('slimscrolling', function (e, pos) {
            if (pos > 0) {
                return;
            }

            if (chat.selectedUser.allPreviousMessagesLoaded) {
                return;
            }

            chat.user.loadMessages(chat.selectedUser);
        });

        var height = $('#kt_quick_sidebar').outerHeight(true) - $("#kt_chat_content .card-header").outerHeight(true) - $('#kt_chat_content .card-footer').outerHeight(true)-50;
        $("#kt_chat_content .slimScrollDiv, #kt_chat_content .card-body").height(height + 'px');
    },

    showMessagesPanel: function () {
        $('.kt-messenger-friends').hide();
        $('#kt_chat_content').show(function () {
            chat.initConversationScrollbar();
            chat.scrollToBottom();
        });
        $('#kt_quick_sidebar_back').removeClass("d-none");
    },

    showFriendsPanel: function () {
        $('.kt-messenger-friends').show();
        $('#kt_chat_content').hide();
        $('#kt_quick_sidebar_back').addClass("d-none");
    },

    changeFriendState: function (user, state) {
        var friend = chat.getFriendOrNull(user.friendUserId, user.friendTenantId);
        if (!friend) {
            return;
        }

        friend.state = state;
        chat.renderFriendLists(chat.friends);
    },

    getFormattedFriends: function (friends) {
        $.each(friends, function (index, friend) {
            friend.shownUserName = chat.user.getShownUserName(friend.friendTenancyName, friend.friendUserName);
        });

        return friends;
    },

    renderFriendList: function (friends, $element) {
        var template = $('#UserFriendTemplate').html();
        Mustache.parse(template);

        var rendered = Mustache.render(template, friends);
        $element.html(rendered);
    },

    renderFriendLists: function (friends) {
        friends = chat.getFormattedFriends(friends);

        var acceptedFriends = _.where(friends, {state: app.consts.friendshipState.accepted});
        chat.renderFriendList(acceptedFriends, $('#friendListFriends'));

        var blockedFriends = _.where(friends, {state: app.consts.friendshipState.blocked});
        chat.renderFriendList(blockedFriends, $('#friendListBlockeds'));

        if (acceptedFriends.length) {
            $('#EmptyFriendListInfo').hide();
        } else {
            $('#EmptyFriendListInfo').show();
        }

        if (blockedFriends.length) {
            $('#EmptyBlockedFriendListInfo').hide();
        } else {
            $('#EmptyBlockedFriendListInfo').show();
        }
    },

    //Messages
    sendMessage: function () {
        if (!$('form[name=\'chatMessageForm\']').valid() || chat.selectedUser.state === app.consts.friendshipState.blocked) {
            return;
        }

        $('#SendChatMessageButton').attr('disabled', 'disabled');

        app.chat.sendMessage({
            tenantId: chat.selectedUser.friendTenantId,
            userId: chat.selectedUser.friendUserId,
            message: $('#ChatMessage').val(),
            tenancyName: app.session.tenant ? app.session.tenant.tenancyName : null,
            userName: app.session.user.userName,
            profilePictureId: app.session.user.profilePictureId
        }, function () {
            $('#ChatMessage').val('');
            $('#SendChatMessageButton').removeAttr('disabled');
        });
    },

    getFormattedMessages: function (messages) {
        $.each(messages, function (index, message) {
            message.creationTime = chat.getFixedMessageTime(message.creationTime);
            message.isIn = message.side !== app.chat.side.sender;
            message.shownUserName = message.side === app.chat.side.sender
                ? app.session.user.userName
                : chat.selectedUser.friendUserName;

            var readStateClass = message.receiverReadState === app.chat.readState.read ? ' text-primary' : ' text-muted';
            message.readStateCheck = message.side === app.chat.side.sender ? '<i class="read-state-check fa fa-check' + readStateClass + '" aria-hidden="true"></i>' : '';

            if (message.message.startsWith('[image]')) {
                var image = JSON.parse(message.message.substring('[image]'.length));
                var imageUrl = abp.appPath + 'App/Chat/GetImage?id=' + message.id + '&contentType=' + image.contentType;
                var uploadedImageMsg = '<a href="' + imageUrl + '" target="_blank"><img src="' + imageUrl + '" class="chat-image-preview"></a>';

                message.formattedMessage = uploadedImageMsg;
            } else if (message.message.startsWith('[file]')) {
                var file = JSON.parse(message.message.substring('[file]'.length));
                var fileUrl = abp.appPath + 'App/Chat/GetFile?id=' + message.id + '&contentType=' + file.contentType;
                var uploadedFileMsg = '<a href="' + fileUrl + '" target="_blank" class="chat-file-preview"><i class="la la-file"></i> ' + file.name + ' <i class="la la-download pull-right"></i></a>';

                message.formattedMessage = uploadedFileMsg;
            } else if (message.message.startsWith('[link]')) {
                var linkMessage = JSON.parse(message.message.substring('[file]'.length));

                message.formattedMessage = '<a href="' + linkMessage.message + '" target="_blank" class="chat-link-message"><i class="fa fa-link"></i> ' + linkMessage.message + '</a>';
            } else {
                message.formattedMessage = Mustache.escape(message.message);
            }
        });

        return messages;
    },

    renderMessages: function (messages) {
        messages = chat.getFormattedMessages(messages);
        console.log(messages);
        var template = $('#UserChatMessageTemplate').html();
        Mustache.parse(template);

        return Mustache.render(template, messages);
    },

    scrollToBottom: function () {
        var scrollToVal = $('#kt_chat_content .card-body').prop('scrollHeight') + 'px';
        $('#kt_chat_content .card-body').slimScroll({scrollTo: scrollToVal});
    },

    //Events & UI

    adjustNotifyPosition: function () {
        if (chat.isOpen) {
            app.changeNotifyPosition('toast-chat-open');
        } else {
            app.changeNotifyPosition('toast-bottom-right');
        }
    },

    triggerUnreadMessageCountChangeEvent: function () {
        var totalUnreadMessageCount = 0;
        if (chat && chat.friends) {
            totalUnreadMessageCount = _.reduce(chat.friends, function (memo, friend) {
                return memo + friend.unreadMessageCount;
            }, 0);
        }

        abp.event.trigger('app.chat.unreadMessageCountChanged', totalUnreadMessageCount);
    },

    bindUiEvents: function () {
        new KTOffcanvas('kt_quick_sidebar', {
            overlay: false,
            baseClass: 'offcanvas',
            placement: 'right',
            closeBy: 'kt_quick_sidebar_close',
            toggleBy: 'kt_quick_sidebar_toggle'
        })

        $('#kt_quick_sidebar').on('click', '#kt_quick_sidebar_back', function () {
            chat.selectedUser = null;
            chat.changeChatUserOnLocalStorage();
            
        });

        $('#kt_quick_sidebar_toggle').on('click', function () {
            chat.isOpen = $('#kt_quick_sidebar').hasClass('offcanvas-on');
            chat.adjustNotifyPosition();
            chat.changeChatPanelIsOpenOnLocalStorage();
            chat.user.markAllUnreadMessagesOfUserAsRead(chat.selectedUser);
        });

        $('#friendListFriends,#friendListBlockeds').on('click', '.chat-user', function () {
            var friendUserId = $(this).attr('data-friend-user-id');
            var friendTenantId = $(this).attr('data-friend-tenant-id');
            chat.selectFriend(friendUserId, friendTenantId);
        });

        $('#kt_quick_sidebar_back').on('click', function () {
            chat.showFriendsPanel();
        });

        $('#liBanChatUser a').click(function () {
            chat.user.block(chat.selectedUser);
        });
        $('#liUnbanChatUser, #UnblockUserButton').click(function () {
            chat.user.unblock(chat.selectedUser);
        });

        $(window).on('resize', function () {
            chat.initConversationScrollbar();
        });

        $('#SearchChatUserButton').click(function () {
            chat.user.search();
        });

        $('#ChatUserSearchUserName, #ChatUserSearchTenancyName').keypress(function (e) {
            if (e.which === 13) {
                chat.user.search();
            }
        });

        $('#ChatMessage').keypress(function (e) {
            if (e.which === 13) {
                e.preventDefault();
                chat.sendMessage();
            }
        });

        $('#SendChatMessageButton').click(function (e) {
            chat.sendMessage();
        });

        $('#ChatUserSearchUserName').on('keyup', function () {
            var userName = $(this).val();
            if (userName) {
                $('#SearchChatUserButton').removeClass('d-none');
            } else {
                $('#SearchChatUserButton').addClass('d-none');
            }

            var friends = _.filter(chat.friends, function (friend) {
                return chat.user.getShownUserName(friend.friendTenancyName, friend.friendUserName).toLowerCase().indexOf(userName.toLowerCase()) >= 0;
            });

            chat.renderFriendLists(friends);
        });

        $('div#kt_quick_sidebar').on('mouseleave', function (e) {
            if (chat.pinned || $(e.target).attr("data-toggle") === 'popover') { // don't hide chat panel when mouse is on popover notification
                return;
            }

            chat.hideChatPanel();
        });

        $('form[name=\'chatMessageForm\']').validate({
            invalidHandler: function () {
                $('#SendChatMessageButton').attr('disabled', 'disabled');
            },
            errorPlacement: function () {

            },
            success: function () {
                $('#SendChatMessageButton').removeAttr('disabled');
            }
        });

        $('.page-quick-sidebar-pinner').click(function () {
            chat.changeChatPanelPinned(!chat.pinned);
        });

        if (!chat.tenantToTenantChatAllowed && chat.tenantToHostChatAllowed) {
            $('#InterTenantChatHintIcon').hide();
        }

        abp.event.on('app.show.quickUserPanel', ()=> {
           chat.hideChatPanel();
        });
    },

    hideChatPanel: function (){
        $('body, #kt_quick_sidebar').removeClass('offcanvas-on');
        var quickSidebarOffCanvas = new KTOffcanvas('kt_quick_sidebar');
        quickSidebarOffCanvas.hide();
        chat.isOpen = false;
        chat.adjustNotifyPosition();
        chat.changeChatPanelIsOpenOnLocalStorage();
    },
    
    registerEvents: function () {

        abp.event.on('app.chat.messageReceived', function (message) {
            var user = chat.getFriendOrNull(message.targetUserId, message.targetTenantId);

            if (user) {
                user.messages = user.messages || [];
                user.messages.push(message);

                if (message.side === app.chat.side.receiver) {
                    user.unreadMessageCount += 1;
                    message.readState = app.chat.readState.unread;
                    chat.user.changeUnreadMessageCount(user.friendTenantId, user.friendUserId, user.unreadMessageCount);
                    chat.triggerUnreadMessageCountChangeEvent();

                    if (chat.isOpen && chat.selectedUser !== null && user.friendTenantId === chat.selectedUser.friendTenantId && user.friendUserId === chat.selectedUser.friendUserId) {
                        chat.user.markAllUnreadMessagesOfUserAsRead(chat.selectedUser);
                    } else {
                        abp.notify.info(
                            abp.utils.formatString('{0}: {1}', user.friendUserName, abp.utils.truncateString(message.message, 100)),
                            null,
                            {
                                onclick: function () {
                                    if (!$('#kt_quick_sidebar').hasClass('offcanvas-on')) {
                                        $('#kt_quick_sidebar').addClass('offcanvas-on');
                                        chat.isOpen = true;
                                        chat.changeChatPanelIsOpenOnLocalStorage();
                                    }

                                    chat.showMessagesPanel();

                                    chat.selectFriend(user.friendUserId, user.friendTenantId);
                                    chat.changeChatPanelPinned(true);
                                }
                            });
                    }
                }

                if (chat.selectedUser !== null && user.friendUserId === chat.selectedUser.friendUserId && user.friendTenantId === chat.selectedUser.friendTenantId) {
                    var renderedMessage = chat.renderMessages([message]);
                    $('#UserChatMessages').append(renderedMessage);
                    $(".timeago").timeago();
                }

                chat.scrollToBottom();
            }
        });

        abp.event.on('app.chat.friendshipRequestReceived', function (data, isOwnRequest) {
            if (!isOwnRequest) {
                abp.notify.info(abp.utils.formatString(app.localize('UserSendYouAFriendshipRequest'), data.friendUserName));
            }

            if (!_.where(chat.friends, {userId: data.friendUserId, tenantId: data.friendTenantId}).length) {
                chat.friends.push(data);
                chat.renderFriendLists(chat.friends);
            }
        });

        abp.event.on('app.chat.userConnectionStateChanged', function (data) {
            chat.user.setFriendOnlineStatus(data.friend.userId, data.friend.tenantId, data.isConnected);
        });

        abp.event.on('app.chat.userStateChanged', function (data) {
            var user = chat.getFriendOrNull(data.friend.userId, data.friend.tenantId);
            if (!user) {
                return;
            }

            user.state = data.state;
            chat.renderFriendLists(chat.friends);
        });

        abp.event.on('app.chat.allUnreadMessagesOfUserRead', function (data) {
            var user = chat.getFriendOrNull(data.friend.userId, data.friend.tenantId);
            if (!user) {
                return;
            }

            user.unreadMessageCount = 0;
            chat.user.changeUnreadMessageCount(user.friendTenantId, user.friendUserId, user.unreadMessageCount);
            chat.triggerUnreadMessageCountChangeEvent();
        });

        abp.event.on('app.chat.readStateChange', function (data) {
            var user = chat.getFriendOrNull(data.friend.userId, data.friend.tenantId);
            if (!user) {
                return;
            }

            $.each(user.messages,
                function (index, message) {
                    message.receiverReadState = app.chat.readState.read;
                });

            if (chat.selectedUser && chat.selectedUser.friendUserId === data.friend.userId) {
                $('.read-state-check').not('.m--font-info').addClass('m--font-info');
            }
        });

        abp.event.on('app.chat.connected', function () {
            $('#chat_is_connecting_icon').hide();
            $('#kt_quick_sidebar_toggle').removeClass('d-none');
            chat.getFriendsAndSettings(function () {
                chat.bindUiEvents();
                chat.loadLastState();
            });
        });
    },

    init: function () {
        chat.registerEvents();

        chat.interTenantChatAllowed = abp.features.isEnabled('App.ChatFeature.TenantToTenant') ||
            abp.features.isEnabled('App.ChatFeature.TenantToHost') ||
            !app.session.tenant;

        $('[data-toggle="popover"]').popover();
    },

    user: {
        loadingPreviousUserMessages: false,
        userNameFilter: '',

        getShownUserName: function (tenanycName, userName) {
            return (tenanycName ? tenanycName : '.') + '\\' + userName;
        },

        block: function (user) {
            friendshipService.blockUser({
                userId: user.friendUserId,
                tenantId: user.friendTenantId
            }).done(function () {
                chat.changeFriendState(user, app.consts.friendshipState.blocked);
                abp.notify.info(app.localize('UserBlocked'));

                $('#ChatMessage').attr("disabled", "disabled");
                $('#SendChatMessageButton').attr("disabled", "disabled");
                $('#liBanChatUser, #ChatMessageWrapper').hide();
                $('#liUnbanChatUser, #UnblockUserButton').show();
            });
        },

        unblock: function (user) {
            friendshipService.unblockUser({
                userId: user.friendUserId,
                tenantId: user.friendTenantId
            }).done(function () {
                chat.changeFriendState(user, app.consts.friendshipState.accepted);
                abp.notify.info(app.localize('UserUnblocked'));

                $('#ChatMessage').removeAttr("disabled");
                $('#ChatMessage').focus();
                $('#SendChatMessageButton').removeAttr("disabled");
                $('#liBanChatUser, #ChatMessageWrapper').show();
                $('#liUnbanChatUser, #UnblockUserButton').hide();
            });
        },

        markAllUnreadMessagesOfUserAsRead: function (user) {
            if (!user || !chat.isOpen) {
                return;
            }

            var unreadMessages = _.where(user.messages, {readState: app.chat.readState.unread});
            var unreadMessageIds = _.pluck(unreadMessages, 'id');

            if (!unreadMessageIds.length) {
                return;
            }

            chatService.markAllUnreadMessagesOfUserAsRead({
                tenantId: user.friendTenantId,
                userId: user.friendUserId
            }).done(function () {
                $.each(user.messages,
                    function (index, message) {
                        if (unreadMessageIds.indexOf(message.id) >= 0) {
                            message.readState = app.chat.readState.read;
                        }
                    });
            });
        },

        changeUnreadMessageCount: function (tenantId, userId, messageCount) {
            if (!tenantId) {
                tenantId = '';
            }
            var $userItems = $('#friendListFriends div.chat-user[data-friend-tenant-id="' + tenantId + '"][data-friend-user-id="' + userId + '"]');
            if ($userItems) {
                var $item = $($userItems[0]).find('span.label');
                $item.html(messageCount);

                if (messageCount) {
                    $item.removeClass('d-none');
                } else {
                    $item.addClass('d-none');
                }
            }
        },

        loadMessages: function (user, callback) {
            chat.user.loadingPreviousUserMessages = true;

            var minMessageId = null;
            if (user.messages && user.messages.length) {
                minMessageId = _.min(user.messages, function (message) {
                    return message.id;
                }).id;
            }

            chatService.getUserChatMessages({
                minMessageId: minMessageId,
                tenantId: user.friendTenantId,
                userId: user.friendUserId
            }).done(function (result) {
                if (!user.messages) {
                    user.messages = [];
                }

                user.messages = result.items.concat(user.messages);

                chat.user.markAllUnreadMessagesOfUserAsRead(user);

                if (!result.items.length) {
                    user.allPreviousMessagesLoaded = true;
                }

                var renderedMessages = chat.renderMessages(user.messages);
                $('#UserChatMessages').html(renderedMessages);

                $(".timeago").timeago();

                chat.user.loadingPreviousUserMessages = false;

                if (callback) {
                    callback();
                }
            });
        },

        openSearchModal: function (tenantId) {
            var lookupModal = app.modals.LookupModal.create({
                title: app.localize('SelectAUser'),
                serviceMethod: abp.services.app.commonLookup.findUsers,
                filterText: $('#ChatUserSearchUserName').val(),
                extraFilters: {tenantId: tenantId}
            });

            lookupModal.open({}, function (selectedItem) {
                var userId = selectedItem.value;
                friendshipService.createFriendshipRequest({
                    userId: userId,
                    tenantId: app.session.tenant !== null ? app.session.tenant.id : null
                }).done(function () {
                    $('#ChatUserSearchUserName').val('');
                });
            });
        },

        search: function () {
            var userNameValue = $('#ChatUserSearchUserName').val();
            var tenancyName = '';
            var userName = '';

            if (userNameValue.indexOf('\\') === -1) {
                userName = userNameValue;
            } else {
                var tenancyAndUserNames = userNameValue.split('\\');
                tenancyName = tenancyAndUserNames[0];
                userName = tenancyAndUserNames[1];
            }

            if (!tenancyName || !chat.interTenantChatAllowed) {
                chat.user.openSearchModal(app.session.tenant ? app.session.tenant.id : null, userName);
            } else {
                friendshipService.createFriendshipRequestByUserName({
                    tenancyName: tenancyName,
                    userName: userName
                }).done(function () {
                    $('#ChatUserSearchUserName').val('');
                });
            }
        },

        setFriendOnlineStatus: function (userId, tenantId, isOnline) {
            var user = chat.getFriendOrNull(userId, tenantId);
            if (!user) {
                return;
            }

            user.isOnline = isOnline;

            var statusClass = 'label label-xl label-dot label-' + (isOnline ? 'success' : 'secondary');

            var $userItems = $('#friendListFriends div.chat-user[data-friend-tenant-id="' + (tenantId ? tenantId : '') + '"][data-friend-user-id="' + userId + '"]');
            if ($userItems) {
                $($userItems[0]).find('.label-dot').attr('class', statusClass);
            }

            if (chat.selectedUser &&
                tenantId === chat.selectedUser.friendTenantId &&
                userId === chat.selectedUser.friendUserId) {

                chat.user.setSelectedUserOnlineStatus(isOnline);
            }
        },

        setSelectedUserOnlineStatus: function (isOnline) {
            if (chat.selectedUser) {
                var statusClass = 'label label-dot label-' + (isOnline ? 'success' : 'secondary');
                $('#selectedChatUserStatus span:eq(0)').attr('class', statusClass);
                $('#selectedChatUserStatus span:eq(1)').text(app.localize(isOnline ? 'Online' : 'Offline'));
            }
        }
    }
};

chat.init();

(function ($) {
    $(function () {
        // Change this to the location of your server-side upload handler:
        var url = abp.appPath + 'App/Chat/UploadFile';

        //image upload
        $('#chatImageUpload').fileupload({
            url: url,
            dataType: 'json',
            maxFileSize: 999000,
            dropZone: null,
            done: function (e, response) {
                var jsonResult = response.result;

                $('#ChatMessage').val('[image]{"id":"' + jsonResult.result.id + '", "name":"' + jsonResult.result.name + '", "contentType":"' + jsonResult.result.contentType + '"}');
                chat.sendMessage();
                $('.chat-progress-bar').hide();
            },
            progressall: function (e, data) {
                var progress = parseInt(data.loaded / data.total * 100, 10);
                $('.chat-progress-bar').show();
                $('#chatFileUploadProgress .progress-bar').css(
                    'width',
                    progress + '%'
                );
            }
        }).prop('disabled', !$.support.fileInput)
            .parent()
            .addClass($.support.fileInput ? undefined : 'disabled');

        //file upload
        $('#chatFileUpload').fileupload({
            url: url,
            dataType: 'json',
            maxFileSize: 999000,
            dropZone: null,
            done: function (e, response) {
                var jsonResult = response.result;

                $('#ChatMessage').val('[file]{"id":"' + jsonResult.result.id + '", "name":"' + jsonResult.result.name + '", "contentType":"' + jsonResult.result.contentType + '"}');
                chat.sendMessage();
                $('.chat-progress-bar').hide();
            },
            progressall: function (e, data) {
                var progress = parseInt(data.loaded / data.total * 100, 10);
                $('.chat-progress-bar').show();
                $('#chatFileUploadProgress .progress-bar').css(
                    'width',
                    progress + '%'
                );
            }
        }).prop('disabled', !$.support.fileInput)
            .parent()
            .addClass($.support.fileInput ? undefined : 'disabled');


        $('#btnLinkShare').click(function () {
            $('#chatDropdownToggle').dropdown('toggle');
            $('#ChatMessage').val('[link]{"message":"' + window.location.href + '"}');
            chat.sendMessage();
        });

        $('.fileinput-button').click(function () {
            $('#chatDropdownToggle').dropdown('toggle');
        });
    });
})(jQuery);
