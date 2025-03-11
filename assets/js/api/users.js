import { pythonURI, fetchOptions } from './config.js';

export async function getUserProfile() {
    try {
        const response = await fetch(`${pythonURI}/api/user`, fetchOptions);
        if (!response.ok) {
            throw new Error('Failed to fetch user profile');
        }
        return await response.json();
    } catch (error) {
        console.error('Error fetching user profile:', error);
        return null;
    }
}
