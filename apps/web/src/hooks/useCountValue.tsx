import { useEffect, useState } from "react";
const API_URL = import.meta.env.VITE_API_URL;

export function useCountValue() {
  const [loading, setLoading] = useState(true);
  const [countValue, setCountValue] = useState("");
  useEffect(() => {
    async function route() {
      const res = await fetch(`${API_URL}`);
      const data = await res.json();
      setCountValue(data.count);
      setLoading(false);
    }
    route();
  }, [countValue, setLoading, setCountValue]);
  return {
    loading,
    countValue,
  };
}
