import { fetchOptions, pythonURI } from "./config.js";

export async function getListings() {
    const endpoint = pythonURI + "/api/fetchListings"
    try {
        const response = await fetch(endpoint, fetchOptions)
        if (!response.ok) {
            throw new error('Failed to fetch listings:' + response.status)
        }
        const listings = await response.json()
        return listings
    } catch {
        console.error("Error fetching listings"+ error.message)
        return null
    }
}