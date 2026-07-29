import { useEffect, useState } from "react";
import { useCountValue } from "./useCountValue";

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
      await fetch(`http://localhost:3000/count/${count}`, {
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
