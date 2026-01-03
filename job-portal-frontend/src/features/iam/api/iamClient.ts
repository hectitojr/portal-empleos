import { bffFetchOrThrow } from '@/lib/api/bffClient';

export type DocumentType = 'DNI' | 'CE' | 'PASSPORT';

export type UpdateMyIdentityRequest = {
  documentType: DocumentType;
  documentNumber: string;
};

export type MessageResponse = {
  code: string;
  message: string;
  traceId: string | null;
  timestamp: string;
};

const UPDATE_IDENTITY_ENDPOINT = '/api/iam/me/identity';

export function updateMyIdentity(payload: UpdateMyIdentityRequest): Promise<MessageResponse> {
  return bffFetchOrThrow<MessageResponse>(UPDATE_IDENTITY_ENDPOINT, {
    method: 'PUT',
    headers: { 'Content-Type': 'application/json' },
    credentials: 'same-origin',
    body: JSON.stringify(payload),
  });
}
