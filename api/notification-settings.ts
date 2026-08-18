import type { NotificationSettings } from '../app/models/notificationSettings';

export function getNotificationSettings(userId: string): NotificationSettings {
  return { userId, emailEnabled: true, smsEnabled: false };
}
