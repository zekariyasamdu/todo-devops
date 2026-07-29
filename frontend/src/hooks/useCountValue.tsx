import { useEffect, useState } from "react";

export function useCountValue() {
  const [loading, setLoading] = useState(true);
  const [countValue, setCountValue] = useState("");
  useEffect(() => {
    async function route() {
      const res = await fetch(`http://localhost:3000/`);
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
