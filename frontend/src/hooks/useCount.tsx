import { useEffect, useState } from "react";
import { useCountValue } from "./useCountValue";
const API_URL = import.meta.env.VITE_API_URL;

export function useCount() {
  const [loading, setLoading] = useState(false);
  const { countValue, loading: countLoading } = useCountValue();
  const [count, setCount] = useState("");
  useEffect(() => {
    setCount(countValue);
  }, [countLoading]);
  useEffect(() => {
    async function route() {
      setLoading(true);
      await fetch(`${API_URL}/count/${count}`, {
        method: "PUT",
      });
      setLoading(false);
    }
    route();
  }, [count]);
  return {
    loading,
    count,
    setCount,
  };
}
