

notification_dict = {}


def register_notification_class(notification_class):
    """
    register_notification_class
    """
    notification_dict[notification_class.__name__] = notification_class


def get_notification_class(notification_class_name):
    if notification_class_name not in notification_dict:
        raise Exception('Notification Class [{}] was not registered'.format(notification_class_name))
    return notification_dict[notification_class_name]
